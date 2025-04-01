import {BasicDataSource} from './BasicDataSource'
import {Result} from '../type/moduleType';
export class NewListDataClassSource extends BasicDataSource{
  private news:Result[]=[]

  totalCount(): number {
    return this.news.length
  }

  getData(index: number): Result {
    return this.news[index]
  }
  addData(index:number,data:Result){
    this.news.splice(index,0,data)
    this.notifyDataAdd(index)
  }
  pushData(data:Result){
    this.news.push(data)
    this.notifyDataAdd(this.news.length-1)
  }
}