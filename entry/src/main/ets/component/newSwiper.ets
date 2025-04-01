
import {newSwiperItemType,moduleData,moduleId,Result} from '../common/type/moduleType';
import {queryDatas} from '../common/api/moduleApi'
import { AxiosResponse, AxiosError } from '@ohos/axios'
import { hilog } from '@kit.PerformanceAnalysisKit';
import uinfo from '../common/utils/getUserInfo';


@Component
export default  struct newSwiper {
  @Prop freshPageNum:number
  @Prop modules:string
  @Prop pageId:string
  @State moduleData:Result[]=[]
  private swiperController: SwiperController = new SwiperController()
  @State currentIndex:number=0

  aboutToAppear(): void {
    this.getNewSwiperData()
  }
  // 获取模块详情
  getNewSwiperData(){
    let modules = `${this.modules}_${this.freshPageNum}_10`
    queryDatas(this.pageId,modules,uinfo.getProductId())
      .then((response: AxiosResponse<newSwiperItemType>) => {
        const data = response.data;
        if (data&&data.code===0) {
          this.moduleData = data.data[this.modules].docs.results
          hilog.info(0x0000, '请求成功', '新版轮播moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        } else {
          hilog.info(0x0000, '请求失败1', '新版轮播moduleData : %{public}s', JSON.stringify(this.moduleData) ?? '');
        }
      })
      .catch((err: AxiosError<newSwiperItemType>) => {
        console.log('请求出错:', err.message);
      });
  }
  build() {
    // Stack({ alignContent: Alignment.Bottom}){
      Column(){
        Swiper(this.swiperController){
          ForEach(this.moduleData, (item:Result,index) => { // 使用this.data代替this.moduleData
            Stack({ alignContent: Alignment.Bottom}) {
              Column(){

                Image(item.thumbnail)
                  .alt($r('app.media.defaultImage'))
                  .width('100%')
                  .aspectRatio(16/9)
              }
              Row(){
                Text(item.title)
                  .textOverflow({overflow:TextOverflow.Ellipsis})
                  .maxLines(1)
                  .fontColor('#fff')
                  .layoutWeight(1)
                  .fontSize(14)

                Text(`${index+1}/${this.moduleData.length}`)
                  .fontColor('#000')
                  .backgroundColor('#fff')
                  .padding({left:5,right:5})
                  .borderRadius('50%')
                  .fontSize(12)
              }
              .padding({bottom:5})
              .width('100%')
            }
            .onClick(() => {
                console.log('进入专题',JSON.stringify(item))
            })

          }, (item: Result,index: number) => JSON.stringify(index))
        }
        .cachedCount(2)
        .index(1)
        .autoPlay(true)
        .interval(4000)
        .loop(true)
        .duration(500)
        .itemSpace(0)
        .indicator( // 设置圆点导航点样式
          false
        )
        .displayArrow(
          false,
          false
        )
        .curve(Curve.Sharp)
        .onChange((index: number) => {
          this.currentIndex = index
        })
      }

    // }
  }

}