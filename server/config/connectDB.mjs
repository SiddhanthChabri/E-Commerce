// Use import syntax for ES modules
import { PrismaClient } from '@prisma/client';

// Create an instance of PrismaClient
const prisma = new PrismaClient();

// Example function to test connection
async function connectDB() {
  try {
    await prisma.$connect();
    console.log('Connected to the database');
  } catch (error) {
    console.error('Error connecting to the database:', error);
  }
}

connectDB()
  .finally(async () => {
    await prisma.$disconnect();
  });

  export default connectDB;
