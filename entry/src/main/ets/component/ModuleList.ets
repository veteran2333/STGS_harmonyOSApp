// 模块数据来源，0文本  1文章  2直播  3专题  4词标  5媒体号推荐  6:媒体号文章   7：媒体号专题 8:应急信息，9：标签*


import {pageDataType} from '../common/type/userType';
import newSwiper from '../component/newSwiper'
import rollingAnnouncement from '../component/rollingAnnouncement'
import customizeImage from '../component/customizeImage'
import bigImageList from '../component/bigImageList'
import leftWordRightImage from '../component/leftWordRightImage'
import rowMoreImage from '../component/rowMoreImage'
import newsList from '../component/newsList'
import topModule from '../component/topModule'
import WaterFlowPage from '../component/WaterFlowPage'

@Component
export default  struct ModuleList {
  scroller: Scroller = new Scroller()
  // 模块列表
  @Prop modeLIstData:pageDataType[]=[]

  // 下拉刷新
  @State isRefreshing: boolean = false
  // 下拉了几次
  @State freshPageNum:number = 1




  build() {

    Scroll(this.scroller) {
      Column() {
        Refresh({ refreshing: $$this.isRefreshing }) {
          List() {
            ForEach(this.modeLIstData, (item: pageDataType) => {
              ListItem() {
                // 新版轮播图
                if(item.type==='imagesNew') {
                  newSwiper({ pageId: item.pageId, modules: item._id, freshPageNum: this.freshPageNum })
                }else if(item.type==='滚动公告区'){
                  rollingAnnouncement({ pageId: item.pageId, modules: item._id, freshPageNum: this.freshPageNum })
                }else if(item.type==='自定义图片'){
                  customizeImage({ imgUrl: item.imgUrl, imgLink: item.imgLink })
                }else if(item.type==='大图列表'){
                  bigImageList({ pageId: item.pageId, modules: item._id, freshPageNum: this.freshPageNum })
                }else if(item.type==='左文右图'){
                  leftWordRightImage({ pageId: item.pageId, modules: item._id, freshPageNum: this.freshPageNum })
                }else if(item.type==='横版多图') {
                  rowMoreImage({
                    pageId: item.pageId,
                    modules: item._id,
                    freshPageNum: this.freshPageNum,
                    src: item.src
                  })
                }else if(item.type==='文章列表') {
                  newsList({ pageId: item.pageId, modules: item._id, freshPageNum: this.freshPageNum })
                }else if(item.type==='top'){
                  topModule({ pageId: item.pageId, modules: item._id, freshPageNum: this.freshPageNum })
                }else if(item.type==='waterfallFlow'){
                  WaterFlowPage({ pageId: item.pageId, modules: item._id, freshPageNum: this.freshPageNum })
                }else {
                  Text(item.type)
                    .width('70%')
                    .height(80)
                    .fontSize(16)
                    .margin(10)
                    .textAlign(TextAlign.Center)
                    .borderRadius(10)
                    .backgroundColor(0xFFFFFF)
                }
              }
            }, (item: pageDataType) => item._id)
          }
          .onScrollIndex((first: number) => {
            // console.info(first.toString())
          })
          .width('100%')
          .height('100%')
          .alignListItem(ListItemAlign.Center)
          .scrollBar(BarState.Off)
        }
          .onStateChange((refreshStatus: RefreshStatus) => {
            console.info('Refresh onStatueChange state is ' + refreshStatus)
          })
          .onOffsetChange((value: number) => {
            console.info('Refresh onOffsetChange offset:' + value)
          })
          .onRefreshing(() => {
            setTimeout(() => {
              this.isRefreshing = false
            }, 2000)
            console.log('onRefreshing test')
          })
          .backgroundColor('#ecf1f9')
          .refreshOffset(64)
          .pullToRefresh(true)

      }
      .width('100%')
    }

  }
}