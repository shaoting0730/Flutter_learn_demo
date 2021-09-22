// components/tabs/index.js
Component({
    relations: {
        "../tab/index": {
            type: "descendant",
            linked: function (target) {
                //
            }
        }  
    },
    /**
     * 组件的属性列表
     */
    properties: {
        active: {
            type: Number,
            value: 0
        }
    },

    /**
     * 组件的初始数据
     */
    data: {
        children: [],
        active: 0,
        scrollLeft: 100
    },
    /**
     * 组件的方法列表
     */
    methods: {
        onInit: function () {
            const current = this.data.active;
            const nodes = this.getDescendant();
            let children = [];
            nodes.forEach((n, i) => {
                let active = i === current ? "active" : "";
                children.push({
                    title: n.data.title,
                    active: active,
                    disabled: n.data.disabled
                })
            });
            this.setData({ children: children });
            nodes[current].setData({ active: "active" });
        },
        getDescendant: function () {
            return this.getRelationNodes("../tab/index");
        },
        onChange: function (event) {
            const nodes = this.getDescendant();
            let children = this.data.children;
            const prev = this.data.active;
            const current = event.currentTarget.dataset.index;
            children[prev].active = "";
            children[current].active = "active";
            nodes[prev].setData({ active: "" });
            nodes[current].setData({ active: "active" });

            const $this = this;
            const query = wx.createSelectorQuery().in(this);
            query.select(".tab").boundingClientRect(function (res) {
                console.log("tabWidth: ", res.width);
                $this.setData({ scrollLeft: (current - 1) * res.width - res.width / 2 })
            }).exec();

            this.setData({
                children: children,
                active: current
            });

            // 自定义事件
            this.triggerEvent("change", { current: current, title: this.data.children[current].title });
        }
    },
    ready: function() {
        this.onInit();
    },
    externalClasses: ["extended-class"]
})
