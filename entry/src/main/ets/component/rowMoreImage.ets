//横板多图

import {newSwiperItemType,Result,moduleData,liveList} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';
import {MARGIN_TOP_Modules,Font_GRAY}from '../common/style/moduleVariables'

@Component
export default  struct rowMoreImage {
  @Prop freshPageNum:number
  @Prop modules:string
  @Prop pageId:string
  @Prop src:string
  @State moduleData:Result[]|undefined=[]
  @State currentIndex:number=0
  scroller: Scroller = new Scroller()
  @State resData:moduleData={
    code: 0,
    src: '',
    moduleName: '',
    message: '',
    type: '',
    pageNum: 0,
    currentPage: 0,
    strategy: '',
    docs:{
      results:[]
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
        if (data&&data.code===0) {
          this.resData = data.data[this.modules]
          this.moduleData = data?.data[this.modules]?.docs?.results

          hilog.info(0x0000, '请求成功', '横板多图moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '横板多图moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        }
      })
      .catch((err: AxiosError<newSwiperItemType>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
    Row(){
        Text(this.src==='2'?'直播推荐':'专题推荐')  //0文本  1文章  2直播  3专题  4词标  5媒体号推荐  6:媒体号文章   7：媒体号专题 8:应急信息，9：标签*
          .fontColor('#44999a')
          .width(12)
          .margin({ top: '0.00vp', right: '10.00vp', bottom: '0.00vp', left: '00vp' })
          .fontSize(14)
        Column(){

        }
        .margin({left:0,right:18})
        .backgroundColor('#ccc')
        .width(1)
        .height(60)
        Scroll(this.scroller){
          Row(){
            ForEach(this.moduleData, (item:Result,index) => { // 使用this.data代替this.moduleData
              Column(){
                Row(){
                  if(this.src!=='2'){
                    Image(item.thumbnailUrl)
                      .alt($r('app.media.defaultImage'))
                      .width('100%')
                      .borderRadius(5)
                  }else {
                    if(item.lives){
                        Image(item.lives[0].thumbnail)
                          .alt($r('app.media.defaultImage'))
                          .width('100%')
                          .borderRadius(5)
                    }
                  }

                }
                Row(){
                    Text(this.src!=='2'?item.name:item.roomName)
                      .fontSize(12)
                      .textOverflow({overflow:TextOverflow.Ellipsis})
                      .maxLines(1)
                      .width('100%')
                      .margin({top:10})
                }
              }
              .width(100)
              .margin({right:10})
              .padding({top:10,bottom:10})
              .onClick(() => {
                console.log('进入横板多图',JSON.stringify(item))
              })
            }, (item: Result,index: number) => JSON.stringify(index))
          }
        }
        .scrollable(ScrollDirection.Horizontal)

    }
    .padding({left:20,right:40})
    .width('100%')
    .backgroundColor('#fff')
    .margin({top:MARGIN_TOP_Modules})
  }

}