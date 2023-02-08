package com.example.platformview
import android.content.Context
import android.graphics.Color
import android.view.View
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView

class AndroidTextView(context: Context) : PlatformView {
    val contentView: TextView = TextView(context)
    override fun getView(): View {
        return contentView
    }
    override fun dispose() {}
}