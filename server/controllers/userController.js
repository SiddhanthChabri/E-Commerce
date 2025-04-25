import { PrismaClient } from '@prisma/client';
import bcryptjs from 'bcryptjs';
import generatedAccessToken from '../utils/generatedAccessToken.js';
import generatedRefreshToken from '../utils/generatedRefreshToken.js';


const prisma = new PrismaClient();

// Helper Function: Convert BigInt to String
const bigIntToString = (obj) => {
    return JSON.parse(JSON.stringify(obj, (key, value) =>
        typeof value === 'bigint' ? value.toString() : value
    ));
};

// 
export const createUser = async (req, res) => {
    try {
        const { name, email, password, avatar, mobile } = req.body;

        const existingUser = await prisma.publicuser.findUnique({ where: { email } });
        if (existingUser) return res.status(400).json({ error: 'Email already exists' });

        const mobileBigInt = mobile ? BigInt(mobile) : null;

        

        const salt = await bcryptjs.genSalt(10)
        const hashPassword = await bcryptjs.hash(password, salt)

        const payload = {
            name,
            email,
            password : hashPassword
        }

        const newUser = await prisma.publicuser.create({
            data: { ...payload, avatar, mobile: mobileBigInt },
        });

        res.status(201).json({ message: 'User created successfully', user: bigIntToString(newUser) });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Something went wrong' });
    }
};

// Get All Users
export const getUsers = async (req, res) => {
    try {
        const users = await prisma.publicuser.findMany();
        res.json(bigIntToString(users));
    } catch (error) {
        res.status(500).json({ error: 'Something went wrong' });
    }
};

// 🟡 Update User
export const updateUser = async (req, res) => {
    try {
        const { id } = req.params;
        const { name, email, password, avatar, mobile } = req.body;

        const updatedUser = await prisma.publicuser.update({
            where: { id: parseInt(id) },
            data: { name, email, password, avatar, mobile: mobile ? BigInt(mobile) : null },
        });

        res.json({ message: 'User updated successfully', user: bigIntToString(updatedUser) });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Something went wrong or user not found' });
    }
};

// Delete User
export const deleteUser = async (req, res) => {
    try {
        const { id } = req.params;

        await prisma.publicuser.delete({
            where: { id: parseInt(id) },
        });

        res.json({ message: 'User deleted successfully' });
    } catch (error) {
        console.error(error);
        res.status(500).json({ error: 'Something went wrong or user not found' });
    }
};





export async function loginController(req, res) {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ error: "Email and password are required" });
    }

    try {
        const user = await prisma.publicuser.findUnique({ where: { email } });

        if (!user) {
            return res.status(401).json({
                message: "Email not found",
                error: true,
                success: false
            });
        }

        const checkPassword = await bcryptjs.compare(password, user.password);

        if (!checkPassword) {
            return res.status(401).json({
                message: "Incorrect password",
                error: true,
                success: false
            });
        }

        const accesstoken =  await generatedAccessToken(user.id)
        const refreshToken = await generatedRefreshToken(user.id)

        const cookieOption = {
            httpOnly : true,
            secure : true,
            sameSite : "None"
        }
        res.cookie('accesstoken', accesstoken, cookieOption)
        res.cookie('refreshToken', refreshToken, cookieOption)

        return res.json({
            message : "Login successfully",
            error : false,
            success : true,
            data : {
                accesstoken,
                refreshToken
            }

        })
        

    } catch (error) {
        return res.status(500).json({
            message: error.message || "Server error",
            error: true,
            success: false
        });
    }
}

//logout controller
export async function logoutController(req, res){
    try{


        const cookieOption = {
            httpOnly : true,
            secure : true,
            sameSite : "None"
        }
        res.clearCookie("accesstoken", cookieOption); // fix here
        res.clearCookie("refreshToken", cookieOption);


        return res.json({
            message : "Logout successfully",
            error: false,
            success : true
        })
    } catch(error){
        return res.status(500).json({
            message : error.message || error,
            error : true,
            success : false
        })
    }
}
