import { Component } from '@angular/core';
import { AddserviceService } from './addservice.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'webapp-frontend';
  public booklist = [];

  constructor(private books: AddserviceService) { }

  // tslint:disable-next-line:use-life-cycle-interface
  ngOnInit() {
    this.books.getAllBooks().subscribe(data => {
      console.log(data);
      this.booklist = [];
      this.booklist = data;
    });
  }
}
