import {IsNotEmpty ,IsString, IsEmail, MinLength, IsEnum} from "class-validator";
import { Role } from "../user/schemas/user.schema";

export class SignUpDto {
    @IsNotEmpty()
    @IsString()
    readonly name : string;

    @IsNotEmpty()
    @IsEmail({},{message:"please insert valid email"})
    readonly email : string;

    @IsNotEmpty()
    @IsString()
    @MinLength(6)
    readonly password : string;

    @IsNotEmpty()
    @IsEnum(Role)
    readonly role : Role;


}