import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type FeedbackDocument = Feedback & Document;

@Schema(  {timestamps:true,})
export class Feedback {



  @Prop({ required: true })
  customerName: string;

  @Prop()
  message: string;

  @Prop()
  rating: Number;

  @Prop({ default: Date.now })
  createdAt: Date;
}

export const FeedbackSchema = SchemaFactory.createForClass(Feedback);
