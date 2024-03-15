import { Module } from "@nestjs/common";
import { ConfigModule } from "@nestjs/config";
import { JwtModule } from "@nestjs/jwt";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { AuthModule } from "./auth/auth.module";
import { AuthService } from "./auth/auth.service";
import { BoulderModule } from "./boulder/boulder.module";
import { PrismaModule } from "./prisma/prisma.module";
import { PrismaService } from "./prisma/prisma.service";
import { UsersModule } from "./users/users.module";
import { UsersService } from "./users/users.service";

@Module({
	imports: [
		ConfigModule.forRoot(),
		JwtModule,
		AuthModule,
		UsersModule,
		PrismaModule,
		BoulderModule,
	],
	controllers: [AppController],
	providers: [AppService, UsersService, PrismaService, AuthService],
})
export class AppModule {}
