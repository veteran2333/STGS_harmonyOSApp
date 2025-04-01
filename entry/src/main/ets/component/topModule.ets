// 置顶模块

import {newSwiperItemType,Result,liveList} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';
import {TITLE_Font_SIZE,Font_GRAY,TIME_Font_SIZE}from '../common/style/moduleVariables'
import {formatTime} from '../common/utils/tools';

@Component
export default  struct topModule {
  @Prop freshPageNum:number
  @Prop modules:string
  @Prop pageId:string
  @State moduleData:Result[]=[]
  @State currentIndex:number=0

  aboutToAppear(): void {
    this.getBigImgListData()
  }

  // 获取模块详情
  getBigImgListData(){
    let modules = `${this.modules}_${this.freshPageNum}_10`
    queryDatas(this.pageId,modules,uinfo.getProductId())
      .then((response: AxiosResponse<newSwiperItemType>) => {
        const data = response.data;
        if (data&&data.code===0&&data.data[this.modules]) {
          this.moduleData = data.data[this.modules].docs.results
          hilog.info(0x0000, '请求成功', '置顶模块moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '置顶模块moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        }
      })
      .catch((err: AxiosError<newSwiperItemType>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
    Column(){
      ForEach(this.moduleData, (item:Result,index) => { // 使用this.data代替this.moduleData
        Column(){
          Row(){
            Text(item.title)
              .fontSize(12)
          }
          .width('100%')
          .margin({bottom:10})

          Row(){
            Text('置顶')
              .fontSize(10)
              .fontColor('red')
              .margin({right:10})
            Text(item.source)
              .fontSize(10)
              .fontColor(Font_GRAY)
              .layoutWeight(1)
            Text(formatTime(item.pushtime))
              .fontSize(10)
              .fontColor(Font_GRAY)
          }
          .width('100%')
        }
        .width('100%')
        .padding(10)
        .border({
          width:{bottom:1},
          color:'#ccc'
        })
      },(item:Result)=>item._id)


    }
    .width('100%')
    .backgroundColor('#fff')
  }


}