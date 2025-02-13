/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Publicuser" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "avatar" TEXT,
    "mobile" INTEGER,
    "refreshToken" TEXT,
    "address_id" INTEGER,

    CONSTRAINT "Publicuser_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Publicaddress" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "street" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "postal_code" TEXT NOT NULL,

    CONSTRAINT "Publicaddress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Publiccartproduct" (
    "product_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "quantity" INTEGER NOT NULL,

    CONSTRAINT "Publiccartproduct_pkey" PRIMARY KEY ("product_id","user_id")
);

-- CreateTable
CREATE TABLE "Product" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT,
    "unit" TEXT,
    "stock" INTEGER,
    "price" INTEGER,
    "discount" INTEGER,
    "description" TEXT,

    CONSTRAINT "Product_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Category" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT,

    CONSTRAINT "Category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductCategory" (
    "product_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,

    CONSTRAINT "ProductCategory_pkey" PRIMARY KEY ("product_id","category_id")
);

-- CreateTable
CREATE TABLE "SubCategory" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "SubCategory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProductSubCategory" (
    "product_id" INTEGER NOT NULL,
    "sub_category_id" INTEGER NOT NULL,

    CONSTRAINT "ProductSubCategory_pkey" PRIMARY KEY ("product_id","sub_category_id")
);

-- CreateTable
CREATE TABLE "SubCategoryCategory" (
    "subCategoryId" INTEGER NOT NULL,
    "categoryId" INTEGER NOT NULL,

    CONSTRAINT "SubCategoryCategory_pkey" PRIMARY KEY ("subCategoryId","categoryId")
);

-- CreateTable
CREATE TABLE "Orders" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "order_id" INTEGER NOT NULL,
    "product_id" INTEGER NOT NULL,
    "product_name" TEXT,
    "product_image" TEXT,
    "payment_id" INTEGER NOT NULL,
    "payment_status" TEXT,
    "delivery_address_id" INTEGER NOT NULL,
    "subtotal_amount" INTEGER,
    "total_amount" INTEGER,
    "invoice_receipt" TEXT,

    CONSTRAINT "Orders_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Publicuser_email_key" ON "Publicuser"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Publicuser_address_id_key" ON "Publicuser"("address_id");

-- CreateIndex
CREATE UNIQUE INDEX "Publicaddress_user_id_key" ON "Publicaddress"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "Category_name_key" ON "Category"("name");

-- CreateIndex
CREATE UNIQUE INDEX "SubCategory_name_key" ON "SubCategory"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Orders_order_id_key" ON "Orders"("order_id");

-- AddForeignKey
ALTER TABLE "Publicuser" ADD CONSTRAINT "Publicuser_address_id_fkey" FOREIGN KEY ("address_id") REFERENCES "Publicaddress"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Publiccartproduct" ADD CONSTRAINT "Publiccartproduct_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Publiccartproduct" ADD CONSTRAINT "Publiccartproduct_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Publicuser"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductCategory" ADD CONSTRAINT "ProductCategory_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductCategory" ADD CONSTRAINT "ProductCategory_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductSubCategory" ADD CONSTRAINT "ProductSubCategory_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ProductSubCategory" ADD CONSTRAINT "ProductSubCategory_sub_category_id_fkey" FOREIGN KEY ("sub_category_id") REFERENCES "SubCategory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubCategoryCategory" ADD CONSTRAINT "SubCategoryCategory_subCategoryId_fkey" FOREIGN KEY ("subCategoryId") REFERENCES "SubCategory"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SubCategoryCategory" ADD CONSTRAINT "SubCategoryCategory_categoryId_fkey" FOREIGN KEY ("categoryId") REFERENCES "Category"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Publicuser"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_product_id_fkey" FOREIGN KEY ("product_id") REFERENCES "Product"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Orders" ADD CONSTRAINT "Orders_delivery_address_id_fkey" FOREIGN KEY ("delivery_address_id") REFERENCES "Publicaddress"("id") ON DELETE CASCADE ON UPDATE CASCADE;
