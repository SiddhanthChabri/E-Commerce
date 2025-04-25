import { PrismaClient } from '@prisma/client';
import jwt from 'jsonwebtoken';

const prisma = new PrismaClient();

const generatedRefreshToken = async (userId) => {
    const token = jwt.sign(
        { id: userId },
        process.env.SECRET_KEY_REFRESH_TOKEN,
        { expiresIn: '30d' }
    );

    await prisma.publicuser.update({
        where: {
            id: userId,
        },
        data: {
            refreshToken: token,
        },
    });

    return token;
};

export default generatedRefreshToken;
