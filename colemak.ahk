
;先看效果:替换后的布局
/*
 `~  1 2 3 4 5 6 7 8 9 0 - = backsp
Tab   Q W F P G J L U Y ; [ ]  \
Back   A R S T D H N E I O " Enterr
LShift  Z X C V B K M , . / RShiftt
Ctrl Win Alt  Space Alt Menu Fn Ctrl
*/

/*

   l u y
 h n e i o '

   up↑down
 ← ↓ → >> del

*/


;colemak的对应QWERTY键位
e::f
r::p
t::g
y::j
u::l
i::u
o::y
p::;
s::r
d::s
f::t
g::d
j::n
k::e
l::i
`;::o
n::k
; 这里的替换不会影响组合的修饰符
; 比如现在按Ctrl+F就是Ctrl+F,不会是原来的Ctrl+E

;这里是替换大写和退格
CapsLock::ESC
;大写切换不会经常用,平时用shift
LShift & CapsLock::CapsLock
;强烈建议这里换成删除,因为删除的按键距离主键盘过远,影响打字效率
#q:: Send !{f4}
#+l:: Send ^#{right} 
#+j:: Send ^#{left}

;Alt 的 方向组合
!i::send {up}
!k::send {Down}
!j::send {Left}
!l::send {Right}
;h-o> =>> Home End
!h::send {Home}


;Alt shift组合方向键
+!i::send {Shift down}{up}
+!k::send {Shift down}{Down}
+!j::send {Shift down}{Left}
+!l::send {Shift down}{Right}
+!h::send {Shift down}{Home}


;Alt ctrl组合方向键
^!i::send {Ctrl down}{up}
^!k::send {Ctrl down}{Down}
^!j::send {Ctrl down}{Left}
^!l::send {Ctrl down}{Right}
^!h::send {Ctrl down}{Home}


;Alt Ctrl Shift 组合方向键
^+!i::send {Ctrl down}{Shift down}{up}
^+!k::send {Ctrl down}{Shift down}{Down}
^+!j::send {Ctrl down}{Shift down}{Left}
^+!l::send {Ctrl down}{Shift down}{Right}
^+!h::send {Ctrl down}{Shift down}{Home}


