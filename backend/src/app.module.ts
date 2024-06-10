import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config'; 
import { MongooseModule } from '@nestjs/mongoose'; 
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { RoomModule } from './room/room.module';
import { AuthModule } from './auth/auth.module';
import { BookingModule } from './booking/booking.module';
import { FeedbackModule } from './feedback/feedback.module';
import { UserModule } from './auth/user/user.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath:'.env',
      isGlobal:true,
    }),
    MongooseModule.forRoot(process.env.DB_URI),
    RoomModule,
    AuthModule,
    BookingModule,
    FeedbackModule,
    UserModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

