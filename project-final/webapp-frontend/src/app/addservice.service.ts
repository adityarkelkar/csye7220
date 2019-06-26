import { Getdata } from './getdata';
import { Injectable } from '@angular/core';
import { HttpClient, HttpClientModule } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class AddserviceService {

  private addBook = 'http://localhost:8080/library/book/add';
  private getBooks = 'http://localhost:8080/library/books';

  constructor(private http: HttpClient) { }

  bookInsert(params: {}): Observable<any> {
    return this.http.post(this.addBook, params);
  }

  getAllBooks(): Observable<Getdata[]> {
    return this.http.get<Getdata[]>(this.getBooks);
  }

}
