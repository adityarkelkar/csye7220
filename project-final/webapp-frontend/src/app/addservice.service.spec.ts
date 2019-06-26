import { TestBed } from '@angular/core/testing';

import { AddserviceService } from './addservice.service';

describe('AddserviceService', () => {
  beforeEach(() => TestBed.configureTestingModule({}));

  it('should be created', () => {
    const service: AddserviceService = TestBed.get(AddserviceService);
    expect(service).toBeTruthy();
  });
});
