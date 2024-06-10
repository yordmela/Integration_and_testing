import { Module } from '@nestjs/common';
import { RoomController } from './room.controller';
import { RoomService } from './room.service';
import {MongooseModule} from "@nestjs/mongoose";
import { RoomSchema } from './schemas/room.schema';
import { AuthModule } from 'src/auth/auth.module';
import { PassportModule } from '@nestjs/passport';

@Module({
  imports:[
    AuthModule,
    PassportModule.register({ defaultStrategy: 'jwt' }),
    MongooseModule.forFeature([{name:"Room",schema:RoomSchema}])],
  controllers: [RoomController],
  providers: [RoomService]
})
export class RoomModule {}
