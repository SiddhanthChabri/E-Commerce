import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import cookieParser from 'cookie-parser';
import morgan from 'morgan';
import helmet from 'helmet';
import connectDB from './config/connectDB.mjs'; // Importing correctly
import userRoutes from './routes/userRoutes.js';

dotenv.config();

const app = express();
app.use(cors({
    credentials: true,
    origin: process.env.FRONTEND_URL
}));

app.use(express.json());
app.use(cookieParser());
app.use(morgan('dev')); // Fix: 'morgan()' needs an argument like 'dev'
app.use(helmet({
    crossOriginResourcePolicy: false
}));
app.use('/api', userRoutes);

const PORT = process.env.PORT || 8080; // Fix: Correct order


app.use('/api/user', userRoutes)

// Connect to DB and start server
connectDB().then(() => {
    app.listen(PORT, () => {
        console.log("Server is running at port: " + PORT);
    });
}).catch(error => {
    console.error("Database connection failed:", error);
});
