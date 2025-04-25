import jwt from 'jsonwebtoken';

const auth = async (req, res, next) => {
    try {
        const token = req.cookies.accesstoken || req.headers.authorization?.split(" ")[1]        

        console.log("Token from cookies:", req.cookies.accesstoken);
        console.log("Authorization header:", req.headers.authorization);
        console.log("Token used for verification:", token);

        if (!token || typeof token !== 'string') {
            return res.status(401).json({
                message: "Token missing or invalid",
                error: true,
                success: false
            });
        }

        const decoded = jwt.verify(token, process.env.SECRET_KEY_ACCESS_TOKEN);
        req.userId = decoded.id;
        next();
    } catch (error) {
        return res.status(401).json({
            message: error.message || "Unauthorized",
            error: true,
            success: false
        });
    }
};

export default auth;
