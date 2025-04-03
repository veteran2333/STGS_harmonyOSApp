// 文章列表
import {newSwiperItemType,Result,liveList} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';
import {MARGIN_TOP_Modules,Font_GRAY}from '../common/style/moduleVariables'
import {formatTime} from '../common/utils/tools';
import { NewListDataClassSource } from '../common/utils/newListDataClassSource';

@Component
export default  struct H5Links {
  @Prop freshPageNum:number
  @Prop modules:string
  @Prop pageId:string
  @State moduleData:Result[]=[]
  @State currentIndex:number=0
  @State moduleName:string = ''
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

          this.moduleName = data.data[this.modules].moduleName
          this.moduleData = data.data[this.modules].docs.results
          this.newsInfo(this.moduleData)
          hilog.info(0x0000, '请求成功', 'H5外链moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', 'H5外链moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        }
      })
      .catch((err: AxiosError<newSwiperItemType>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
    Column(){
      Row(){
        Row(){}
          .width(4)
          .height(18)
          .backgroundColor('#44999a')
          .margin({right:5})
        Text(this.moduleName)
          .fontWeight(700)
          .fontSize(14)
      }.width('100%')
      Grid() {
        LazyForEach(this.newsList, (item: Result, index) => { // 使用this.data代替this.moduleData
          GridItem() {
            Row(){
              Image(item.thumbnailUrl)
                .alt($r('app.media.defaultImage'))
                .width(32)
                .height(32)
                .borderRadius(16)
                .margin({right:5})
              Text(item.name)
                .fontSize(12)
            }
            .height(60)
            .width('100%')
          }
        }, (item: Result, index: number) => item._id)
      }.columnsTemplate('1fr 1fr')
    }
    .padding({left:10,right:10,top:10})
    .width('100%')
    .backgroundColor('#fff')
    .margin({top:MARGIN_TOP_Modules})
  }
  // 子项内容组件
  @Builder ListItemContent(item: Result) {
    Row() {

    }
    .onClick(() => {
      console.log('进入H5外链', JSON.stringify(item))
    })
    .width('100%')
  }
}