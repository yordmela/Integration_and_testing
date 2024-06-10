import {IsNotEmpty ,IsString} from "class-validator";

export class UpdateFeedbackDto {
    @IsNotEmpty()
    @IsString()
    customerName?: string;

    @IsNotEmpty()
    @IsString()
    message?: string;
  }
  