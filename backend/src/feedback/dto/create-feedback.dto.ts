import {IsNotEmpty ,IsNumber,IsString} from "class-validator";

export class CreateFeedbackDto {
    @IsNotEmpty()
    @IsString()
    customerName?: string;

    @IsNotEmpty()
    @IsString()
    message?: string;

    @IsNotEmpty()
    @IsNumber()
    rating?: Number;
  }
  