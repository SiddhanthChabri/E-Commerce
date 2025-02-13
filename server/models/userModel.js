import { PrismaClient } from "@prisma/client";
const prisma = new PrismaClient();

export const createUser = async (data) => {
  return await prisma.publicuser.create({ data });
};

export const getUsers = async () => {
  return await prisma.publicuser.findMany();
};

export const getUserById = async (id) => {
  return await prisma.publicuser.findUnique({ where: { id } });
};

export const updateUser = async (id, data) => {
  return await prisma.publicuser.update({ where: { id }, data });
};

export const deleteUser = async (id) => {
  return await prisma.publicuser.delete({ where: { id } });
};
