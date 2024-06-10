import { IsNotEmpty, IsString, IsNumber, IsEnum, IsEmpty } from "class-validator";
import { Category, User } from "../schemas/room.schema";

export class CreateRoomDto {
    @IsNotEmpty()
    @IsString()
    readonly title: string;

    @IsNotEmpty()
    @IsString()
    readonly description: string;

    @IsNotEmpty()
    @IsNumber()
    readonly price: number;

    @IsNotEmpty()
    @IsEnum(Category, { message: "Please enter the correct category." })
    readonly category: Category;

    @IsEmpty({ message: 'You cannot pass user ID.' })
    readonly user: User;

    @IsNotEmpty()
    @IsString()
    readonly image: string;  // Validate image as a non-empty string
}
