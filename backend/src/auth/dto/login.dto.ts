import {IsNotEmpty ,IsString, IsEmail, MinLength} from "class-validator";

export class LoginDto {

    @IsNotEmpty()
    @IsEmail({},{message:"please insert valid email"})
    readonly email : string;

    @IsNotEmpty()
    @IsString()
    @MinLength(6)
    readonly password : string;


}