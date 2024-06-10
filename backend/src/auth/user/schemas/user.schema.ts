import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export enum Role {
  Admin = 'admin',
  Customer = 'customer',
}

@Schema({ timestamps: true })
export class User extends Document {
  @Prop()
  name: string;

  @Prop({ unique: [true, 'duplicate email entered'] })
  email: string;

  @Prop()
  password: string;

  @Prop({ type: String, enum: Role, default: Role.Customer })
  role: Role;
}

export const UserSchema = SchemaFactory.createForClass(User);
