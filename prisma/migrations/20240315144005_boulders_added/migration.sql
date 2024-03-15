/*
  Warnings:

  - You are about to drop the `Article` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[name]` on the table `Users` will be added. If there are existing duplicate values, this will fail.
  - Made the column `name` on table `Users` required. This step will fail if there are existing NULL values in that column.
  - Made the column `password` on table `Users` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Users" ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "password" SET NOT NULL;

-- DropTable
DROP TABLE "Article";

-- CreateTable
CREATE TABLE "UsersSettings" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,

    CONSTRAINT "UsersSettings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Locations" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "longitude" DOUBLE PRECISION NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "Locations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LocationFavorites" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,
    "locationId" INTEGER NOT NULL,

    CONSTRAINT "LocationFavorites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BoulderRocks" (
    "id" SERIAL NOT NULL,
    "locationId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "image" TEXT,

    CONSTRAINT "BoulderRocks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Boulders" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "grade" TEXT NOT NULL,
    "setter" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "sitStart" BOOLEAN NOT NULL,
    "norwegianRating" BOOLEAN NOT NULL,
    "boulderRockId" INTEGER NOT NULL,

    CONSTRAINT "Boulders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BoulderAscents" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "grade" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "boulderId" INTEGER NOT NULL,

    CONSTRAINT "BoulderAscents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BoulderRating" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "rating" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    "boulderId" INTEGER NOT NULL,

    CONSTRAINT "BoulderRating_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BoulderFavorites" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "userId" INTEGER NOT NULL,
    "boulderId" INTEGER NOT NULL,

    CONSTRAINT "BoulderFavorites_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Locations_name_key" ON "Locations"("name");

-- CreateIndex
CREATE UNIQUE INDEX "BoulderRocks_name_key" ON "BoulderRocks"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Boulders_name_key" ON "Boulders"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Users_name_key" ON "Users"("name");

-- AddForeignKey
ALTER TABLE "UsersSettings" ADD CONSTRAINT "UsersSettings_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationFavorites" ADD CONSTRAINT "LocationFavorites_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LocationFavorites" ADD CONSTRAINT "LocationFavorites_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Locations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BoulderRocks" ADD CONSTRAINT "BoulderRocks_locationId_fkey" FOREIGN KEY ("locationId") REFERENCES "Locations"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Boulders" ADD CONSTRAINT "Boulders_boulderRockId_fkey" FOREIGN KEY ("boulderRockId") REFERENCES "BoulderRocks"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BoulderAscents" ADD CONSTRAINT "BoulderAscents_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BoulderAscents" ADD CONSTRAINT "BoulderAscents_boulderId_fkey" FOREIGN KEY ("boulderId") REFERENCES "Boulders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BoulderRating" ADD CONSTRAINT "BoulderRating_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BoulderRating" ADD CONSTRAINT "BoulderRating_boulderId_fkey" FOREIGN KEY ("boulderId") REFERENCES "Boulders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BoulderFavorites" ADD CONSTRAINT "BoulderFavorites_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BoulderFavorites" ADD CONSTRAINT "BoulderFavorites_boulderId_fkey" FOREIGN KEY ("boulderId") REFERENCES "Boulders"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
