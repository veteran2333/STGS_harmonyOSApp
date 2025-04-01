
import {newSwiperItemType,Result,liveList} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';
import {MARGIN_TOP_Modules,Font_GRAY}from '../common/style/moduleVariables'

@Component
export default  struct bigImageList {
  @Prop freshPageNum:number
  @Prop modules:string
  @Prop pageId:string
  @State moduleData:Result={}
  @State currentIndex:number=0
  @State liveData:liveList[]=[]

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
          this.moduleData = data.data[this.modules].docs.results[0]
          this.liveData = this.moduleData.lives||[]
          hilog.info(0x0000, '请求成功', '大图列表moduleData : %{public}s', JSON.stringify(this.liveData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '大图列表moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        }
      })
      .catch((err: AxiosError<newSwiperItemType>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
    Column(){
      Stack({ alignContent: Alignment.Bottom}) {
        Column() {
            Image(this.liveData[0]?.thumbnail)
              .alt($r('app.media.defaultImage'))
              // .width('100%')
              .height(191.25)
              .aspectRatio(16/9)
              .borderRadius(10)
              .margin({top:10})
            Text(this.moduleData.liveStatus==='back'?'回看':'')
              .backgroundColor('#72000000')
              .height(18)
              .width(36)
              .borderRadius(10)
              .textAlign(TextAlign.Center)
              .fontSize(12)
              .fontColor('#fff')
              .position({
                right:10,
                top:20
              })
        }
        Row(){
          Text(this.moduleData.roomName||'')
            .linearGradient({
              direction: GradientDirection.Bottom, // 渐变方向
              repeating: false, // 渐变颜色是否重复
              colors: [['rgba(0,0,0,0.0)', 0.0], ['rgba(0,0,0,0.6)', 1.0]] // 数组末尾元素占比小于1时满足重复着色效果
            })
            .fontColor('#fff')
            .width('100%')
            .fontSize(12)
            .height(32)
            .borderRadius({bottomLeft:10,bottomRight:10})

        }
      }
      Row(){
        Text(this.moduleData.companyName||'')
          .fontColor(Font_GRAY)
          .fontSize(12)
          .layoutWeight(1)
        Image($r('app.media.more'))
          .height('60%')
      }
        .height(48)
        .width('100%')
    }
    .onClick(() => {
      console.log('点击了大图列表',JSON.stringify(this.moduleData))
    })
    .padding({left:10,right:10})
    .width('100%')
    .backgroundColor('#fff')
    .margin({top:MARGIN_TOP_Modules})
  }

}