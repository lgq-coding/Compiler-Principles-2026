; ModuleID = 'sysy_demo.sy'
source_filename = "sysy_demo.sy"
target triple = "riscv64-unknown-elf"

declare i32 @getint()
declare void @putint(i32)
declare void @putch(i32)

define i32 @is_even(i32 %x) {
entry:
  %remainder = srem i32 %x, 2
  %is.zero = icmp eq i32 %remainder, 0
  br i1 %is.zero, label %even, label %odd

even:
  ret i32 1

odd:
  ret i32 0
}

define i32 @gcd(i32 %a.arg, i32 %b.arg) {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a.arg, ptr %a.addr, align 4
  store i32 %b.arg, ptr %b.addr, align 4
  br label %while.cond

while.cond:
  %b.current = load i32, ptr %b.addr, align 4
  %b.nonzero = icmp ne i32 %b.current, 0
  br i1 %b.nonzero, label %while.body, label %while.end

while.body:
  %a.current = load i32, ptr %a.addr, align 4
  %b.current.2 = load i32, ptr %b.addr, align 4
  %remainder = srem i32 %a.current, %b.current.2
  store i32 %b.current.2, ptr %a.addr, align 4
  store i32 %remainder, ptr %b.addr, align 4
  br label %while.cond

while.end:
  %result = load i32, ptr %a.addr, align 4
  ret i32 %result
}

define i32 @main() {
entry:
  %n.addr = alloca i32, align 4
  %i.addr = alloca i32, align 4
  %sum.addr = alloca i32, align 4
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %mixed.addr = alloca i32, align 4
  %g.addr = alloca i32, align 4

  %n.input = call i32 @getint()
  store i32 %n.input, ptr %n.addr, align 4
  store i32 1, ptr %i.addr, align 4
  store i32 0, ptr %sum.addr, align 4
  br label %while.cond

while.cond:
  %i.current = load i32, ptr %i.addr, align 4
  %n.current = load i32, ptr %n.addr, align 4
  %loop.condition = icmp sle i32 %i.current, %n.current
  br i1 %loop.condition, label %while.body, label %while.end

while.body:
  %i.body = load i32, ptr %i.addr, align 4
  %is.four = icmp eq i32 %i.body, 4
  br i1 %is.four, label %continue.block, label %check.break

continue.block:
  %i.after.continue = add i32 %i.body, 1
  store i32 %i.after.continue, ptr %i.addr, align 4
  br label %while.cond

check.break:
  %is.six = icmp eq i32 %i.body, 6
  br i1 %is.six, label %while.end, label %check.even

check.even:
  %is.positive = icmp sgt i32 %i.body, 0
  br i1 %is.positive, label %call.is.even, label %increment

call.is.even:
  %even.result = call i32 @is_even(i32 %i.body)
  %even.flag = icmp ne i32 %even.result, 0
  br i1 %even.flag, label %add.sum, label %increment

add.sum:
  %sum.current = load i32, ptr %sum.addr, align 4
  %sum.updated = add i32 %sum.current, %i.body
  store i32 %sum.updated, ptr %sum.addr, align 4
  br label %increment

increment:
  %i.increment.source = load i32, ptr %i.addr, align 4
  %i.incremented = add i32 %i.increment.source, 1
  store i32 %i.incremented, ptr %i.addr, align 4
  br label %while.cond

while.end:
  %n.for.x = load i32, ptr %n.addr, align 4
  %x.value = add i32 %n.for.x, 3
  store i32 %x.value, ptr %x.addr, align 4

  %n.for.y = load i32, ptr %n.addr, align 4
  %y.scaled = mul i32 %n.for.y, 2
  %y.value = add i32 %y.scaled, 1
  store i32 %y.value, ptr %y.addr, align 4

  %x.for.sum = load i32, ptr %x.addr, align 4
  %y.for.sum = load i32, ptr %y.addr, align 4
  %xy.sum = add i32 %x.for.sum, %y.for.sum
  %xy.doubled = mul i32 %xy.sum, 2

  %x.for.div = load i32, ptr %x.addr, align 4
  %x.half = sdiv i32 %x.for.div, 2

  %subtotal = sub i32 %xy.doubled, %x.half

  %y.for.rem = load i32, ptr %y.addr, align 4
  %y.remainder = srem i32 %y.for.rem, 3
  %mixed.value = add i32 %subtotal, %y.remainder
  store i32 %mixed.value, ptr %mixed.addr, align 4

  %x.for.gcd = load i32, ptr %x.addr, align 4
  %y.for.gcd = load i32, ptr %y.addr, align 4
  %gcd.value = call i32 @gcd(i32 %x.for.gcd, i32 %y.for.gcd)
  store i32 %gcd.value, ptr %g.addr, align 4

  %sum.output = load i32, ptr %sum.addr, align 4
  call void @putint(i32 %sum.output)
  call void @putch(i32 10)

  %mixed.output = load i32, ptr %mixed.addr, align 4
  call void @putint(i32 %mixed.output)
  call void @putch(i32 10)

  %g.output = load i32, ptr %g.addr, align 4
  call void @putint(i32 %g.output)
  call void @putch(i32 10)

  ret i32 0
}
