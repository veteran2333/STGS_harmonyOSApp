
import {newSwiperItemType,Result,liveList} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';
import {MARGIN_TOP_Modules,Font_GRAY}from '../common/style/moduleVariables'
import {formatTime} from '../common/utils/tools';

@Component
export default  struct leftWordRightImage {
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
        if (data&&data.code===0) {
          this.moduleData = data.data[this.modules].docs.results
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
      ForEach(this.moduleData, (item:Result,index) => { // 使用this.data代替this.moduleData
        Row(){
          Column(){
            Row(){
              Text(item.title)
                .fontSize(12)
                .textOverflow({overflow:TextOverflow.Ellipsis})
                .maxLines(2)
            }
            .width('100%')

            Row(){
              Text(item.source)
                .fontSize(10)
                .layoutWeight(1)
                .fontColor(Font_GRAY)

              Text(formatTime(item.ctime))
                .fontSize(10)
                .fontColor(Font_GRAY)


            }
            .width('100%')

          }
          .layoutWeight(1)
          Image(item.thumbnail)
            .width(90)
            .aspectRatio(16/10)
            .borderRadius(5)
            .margin({left:5,right:5})
        }
        .onClick(() => {
          console.log('进入左文右图',JSON.stringify(item))
        })
        .padding({top:10,bottom:10})
        .border({
          width: {
            top: 0,
            right: 0,
            bottom: 1,
            left: 0
          },
          color: Font_GRAY
        })
        .width('100%')
      }, (item: Result,index: number) => JSON.stringify(index))
    }
    .padding({left:10,right:10})
    .width('100%')
    .backgroundColor('#fff')
    .margin({top:MARGIN_TOP_Modules})
  }

}