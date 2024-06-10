import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { UserController } from './user.controller';
import { UsersService } from './user.service';
import { User, UserSchema } from './schemas/user.schema';
import { PassportModule } from '@nestjs/passport';

@Module({
  imports: [MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
      PassportModule.register({ defaultStrategy: 'jwt' }),
    ],
  controllers: [UserController],
  providers: [UsersService],
})
export class UserModule {}
