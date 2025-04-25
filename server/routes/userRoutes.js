import express from 'express';
import { createUser, getUsers, updateUser, deleteUser, loginController, logoutController } from '../controllers/userController.js';
import auth from '../middleware/auth.js';

const userRoutes = express.Router();

userRoutes.post('/users', createUser);      // Create user
userRoutes.get('/users', getUsers);         // Get all users
userRoutes.put('/users/:id', updateUser);   // Update user by ID
userRoutes.delete('/users/:id', deleteUser); // Delete user by ID

userRoutes.post('/login', loginController)
userRoutes.get('/logout', auth, logoutController)

export default userRoutes;
