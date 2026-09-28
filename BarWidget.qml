pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import qs.Commons
import qs.Ui

BarWidget {
  id: root

  moduleName: "omalock"

  readonly property string helperBin: (root.manifest && root.manifest.__sourceDir
    ? String(root.manifest.__sourceDir).replace(/\/$/, "")
    : Quickshell.env("HOME") + "/.config/omarchy/plugins/omalock") + "/bin/omalock"

  property bool locked: false

  function refresh() {
    if (statusProc.running) return
    statusProc.command = ["bash", root.helperBin, "status"]
    statusProc.running = true
  }

  function toggle() {
    if (toggleProc.running) return
    toggleProc.command = ["bash", root.helperBin, "toggle"]
    toggleProc.running = true
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  Component.onCompleted: root.refresh()

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: root.refresh()
  }

  Process {
    id: statusProc
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.locked = text.trim() === "locked"
    }
  }

  Process {
    id: toggleProc
    onRunningChanged: if (!running) root.refresh()
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.locked ? "󰌾" : "󰌿"
    active: root.locked
    tooltipText: root.locked ? "Window layout locked (click to unlock)" : "Lock window layout"
    onPressed: function(b) { root.toggle() }
  }
}
