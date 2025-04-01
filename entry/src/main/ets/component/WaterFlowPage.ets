
import {newSwiperItemType,Result,liveList} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';
import {MARGIN_TOP_Modules,Font_GRAY}from '../common/style/moduleVariables'
import {formatTime} from '../common/utils/tools';
import { NewListDataClassSource } from '../common/utils/newListDataClassSource';

@Component
export default  struct WaterFlowPage {
  @Prop freshPageNum:number
  @Prop modules:string
  @Prop pageId:string
  @State moduleData:Result[]=[]
  @State currentIndex:number=0

  private  newsList:NewListDataClassSource = new NewListDataClassSource()
  newsInfo(arr:Result[]){
    if(arr&&arr.length){
      for (let index = 0; index < arr.length; index++) {
        this.newsList.pushData(arr[index])
      }
    }
  }




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
          this.newsInfo(this.moduleData)
          hilog.info(0x0000, '请求成功', '左文右图moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '左文右图moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        }
      })
      .catch((err: AxiosError<newSwiperItemType>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
    Column(){
      WaterFlow() {
        LazyForEach(this.newsList, (item: Result, index) => { // 使用this.data代替this.moduleData
          FlowItem() {
            this.ListItemContent(item);
          }
        }, (item: Result, index: number) => item._id)
      }
      .columnsTemplate("1fr 1fr")
      .columnsGap(10)
      .rowsGap(5)
      .width('100%')
      .height('100%')
      .onReachStart(() => {
        console.info('waterFlow reach start');
      })
      .onScrollStart(() => {
        console.info('waterFlow scroll start');
      })
      .onScrollStop(() => {
        console.info('waterFlow scroll stop');
      })
      .onScrollFrameBegin((offset: number, state: ScrollState) => {
        console.info('waterFlow scrollFrameBegin offset: ' + offset + ' state: ' + state.toString());
        return { offsetRemain: offset };
      })
    }
    .padding(5)
    .backgroundColor('#fff')
  }
  // 子项内容组件
  @Builder ListItemContent(item: Result) {
    Column() {
      Image(item.thumbnail)
        .alt($r('app.media.defaultImage'))
        .borderRadius(5)
        .margin({bottom: 10 })
      Text(item.title)
        .textOverflow({overflow:TextOverflow.Ellipsis})
        .maxLines(2)
        .fontSize(12)
      Row(){
        // Image('')
        //   .width(10)
        Text(item.source)
          .fontSize(10)
          .fontColor(Font_GRAY)
          .layoutWeight(1)
        Image($r('app.media.zan'))
          .width(10)
        if(item.likeNum!==undefined){
          Text(JSON.stringify(item.likeNum))
            .fontSize(10)
            .fontColor(Font_GRAY)
            .margin({left:5})
        }
      }
      .margin({top:10})
    }
    .onClick(() => {
      console.log('进入左文右图', JSON.stringify(item))
    })
  }
}