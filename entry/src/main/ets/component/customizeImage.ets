// 自定义图片customizeImage

@Component
export default  struct customizeImage {
  @Prop imgUrl:string
  @Prop imgLink:string



  aboutToAppear(): void {

  }

  build() {
    Column(){
      // 该组件仅支持与系统浏览器配合使用。
      // Hyperlink(this.imgLink) {
      //   Image(this.imgUrl)
      //     .width('100%')
      // }
      Image(this.imgUrl)
        .onClick(() => {
          console.log('点击了自定义图片地址',this.imgLink)
        })
    }
    .margin({top:5})

  }

}