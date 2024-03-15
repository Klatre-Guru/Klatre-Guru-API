import { Module } from '@nestjs/common';
import { BoulderService } from './boulder.service';

@Module({
  providers: [BoulderService]
})
export class BoulderModule {}
