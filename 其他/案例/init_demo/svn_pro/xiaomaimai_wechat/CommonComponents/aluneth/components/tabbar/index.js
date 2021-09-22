// components/tabbar/index.js
Component({
    relations: {
        "../tabbar-item/index": {
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
        },
        fixed: {
            type: Boolean,
            value: true
        }
    },

    /**
     * 组件的初始数据
     */
    data: {

    },

    /**
     * 组件的方法列表
     */
    methods: {
        onInit: function() {
            const current = this.properties.active;
            const nodes = this.getDescendant();
            nodes[current].setData({ active: "active" });
        },
        getDescendant: function () {
            return this.getRelationNodes("../tabbar-item/index");
        },
        onChange: function (descendant) {
            const nodes = this.getDescendant();
            let prev = this.properties.active;
            let current = prev;
            nodes.forEach((n, i) => {
                if(n.data.active === "active") {
                    n.setData({ active: "" });
                    prev = i;
                }
                if(n === descendant) {
                    current = i;
                }
            });

            descendant.setData({ active: "active" });
            this.triggerEvent("change", { prev: prev, current: current, title: descendant.data.title })
        }
    },
    ready: function() {
        this.onInit();
    },
    externalClasses: ["extended-class"]
})
