import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

async function connectDB() {
  try {
    const user = await prisma.user.create({
      data: {
        name: 'John Doe',
        email: 'john@example.com',
      },
    });

    console.log(user);
  } catch (error) {
    console.error('Database connection error:', error);
  } finally {
    await prisma.$disconnect();
  }
}

export default connectDB;
