Component({
    externalClasses: 'class',

    properties: {
        scroll: {
            type: Boolean,
            value: false
        },
        fixed: {
            type: Boolean,
            value: false
        },
        height: {
            type: String,
            value: '90rpx'
        },
        itemMinWidth: {
            type: String,
            value: '60rpx'
        },
        paddingLeft: {
            type: String,
            value: "0",
        },
        paddingRight: {
            type: String,
            value: "0",
        },
        list: {
            type: Array,
            value: []
        },
        selectedId: {
            type: [String, Number],
            value: ''
        }
    },
    data: {
        scrollIntoView: "",
        scrollLeft: 0,
        screenWidth: 375,
    },
    attached: function () {
        console.log(this, "---->tab");
        wx.getSystemInfo({
            success: (res) => {
                this.setData({
                    screenWidth: res.windowWidth,
                });

            }
        })
    },
    methods: {
        _clearTabChangeTimer() {
            if (this._timer_tab_change) {
                clearTimeout(this._timer_tab_change);
                this._timer_tab_change = null;
            }
        },
        _delaySendTabChange(selectedId, e) {
            this._clearTabChangeTimer();
            this._timer_tab_change = setTimeout(() => {
                // const {scroll} = this.properties;
                // if(scroll){
                //     this.scrollTabAuto(e);
                // }
                // console.info('[zan:tab:change] selectedId:', selectedId);
                this.triggerEvent('tabchange', selectedId);
            }, 300);

        },
        scrollTabAuto(e) {
            const {list} = this.properties;
            const {selectedId, screenWidth} = this.data;

            // console.log("-->scrollTabAuto",e);
            const offsetLeft = e.target.offsetLeft;
            const scrollView = this.selectComponent("#tab-scroll-view");

            this.setData({
                scrollLeft: offsetLeft - screenWidth / 3,
            });
        },
        _handleZanTabChange(e) {
            const {scroll} = this.properties;
            const selectedId = e.currentTarget.dataset.itemId;

            this.setData({
                selectedId
            }, () => {
                if (scroll) {
                    this.scrollTabAuto(e);
                }
                this._delaySendTabChange(selectedId, e);
            });
        }
    }
});
