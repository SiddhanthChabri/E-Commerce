import express from 'express';
import { createUser, getUsers, updateUser, deleteUser } from '../controllers/userController.js';

const userRoutes = express.Router();

userRoutes.post('/users', createUser);      // Create user
userRoutes.get('/users', getUsers);         // Get all users
userRoutes.put('/users/:id', updateUser);   // Update user by ID
userRoutes.delete('/users/:id', deleteUser); // Delete user by ID

export default userRoutes;
