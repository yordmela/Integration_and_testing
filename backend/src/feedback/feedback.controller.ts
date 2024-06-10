import { Controller, Post, Body, Get, Put, Delete, Param, UseGuards, Req } from '@nestjs/common';
import { FeedbackService } from './feedback.service';
import { CreateFeedbackDto } from './dto/create-feedback.dto';
import { UpdateFeedbackDto } from './dto/update-feedback.dto';
import { Roles } from 'src/auth/roles.decorator';
import { AuthGuard } from '@nestjs/passport';
import { Role } from 'src/auth/user/schemas/user.schema';


@Controller('feedback')
export class FeedbackController {
  constructor(private readonly feedbackService: FeedbackService) {}

  @Post()
  @Roles(Role.Customer)
  @UseGuards(AuthGuard())
  async createFeedback(@Body() createFeedbackDto: CreateFeedbackDto ,@Req() req) {
    return this.feedbackService.create(createFeedbackDto,req.user);
  }

  @Get()
  async getAllFeedback() {
    return this.feedbackService.findAll();
  }

  @Put('/:id')
  @Roles(Role.Customer)
  @UseGuards(AuthGuard())
  async updateFeedback(@Param('id') id: string, @Body() updateFeedbackDto: UpdateFeedbackDto,@Req() req) {
    return this.feedbackService.update(id, updateFeedbackDto,req.user);
  }

  @Delete('/:id')
  @Roles(Role.Customer)
  @UseGuards(AuthGuard())
  async deleteFeedback(@Param('id') id: string,@Req() req) {
    return this.feedbackService.delete(id,req.user);
  }
}
