import express from 'express';
import { createUser, getUsers, updateUser, deleteUser } from '../controllers/userController.js';

const router = express.Router();

router.post('/users', createUser);      // Create user
router.get('/users', getUsers);         // Get all users
router.put('/users/:id', updateUser);   // Update user by ID
router.delete('/users/:id', deleteUser); // Delete user by ID

export default router;
