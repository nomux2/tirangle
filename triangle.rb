=begin

  与えられた三角形の3辺の長さから、三角形の形を表示するプログラムを作成する
  三辺の長さがa,b,cである三角形が存在する必要十分条件
  
  a + b > c かつ b + c > a かつ c + a > b
  
=end

#三角形クラス
class Triangle
  
  TYPE_NOT_TRIANGEL = -1  #三角形ではない
  TYPE_SCALENE      = 0   #不等辺三角形
  TYPE_EQUILATERAL  = 1   #正三角形
  TYPE_ISOSCELES    = 2   #二等辺三角形
  
  MSG_NOT_NUM_SIDE_1 = "辺1の値が数値じゃないですＴＴ"
  MSG_NOT_NUM_SIDE_2 = "辺2の値が数値じゃないですＴＴ"
  MSG_NOT_NUM_SIDE_3 = "辺3の値が数値じゃないですＴＴ"
  MSG_NOT_TRIANGLE = "三角形じゃないです＞＜"
  MSG_TRIANGLE = "三角形を形成しています"
  MSG_TRIANGLE_EQUILATERAL = "正三角形ですね！"
  MSG_TRIANGLE_ISOSCELES = "二等辺三角形ですね！"
  MSG_TRIANGLE_SCALENE = "不等辺三角形ですね！"

  @a = 0
  @b = 0
  @c = 0
  @msg = ""
  
  attr_accessor :a
  attr_accessor :b
  attr_accessor :c
  attr_reader :msg     #getterのみ

  # 三辺の設定
  # @param [Float] a 辺1
  # @param [Float] b 辺2
  # @param [Float] c 辺3
  def setTriangleSide(a, b, c)
    @a = a
    @b = b
    @c = c
    @msg = ""
  end

  # 三角形の成立条件チェック
  # @return [Bool] 三角形あればtrue、三角形でなければfalse
  def chkFormingCondition
  
    #数値チェック
    if @a.is_a?(Integer) == false && @a.is_a?(Float) == false
      @msg = MSG_NOT_NUM_SIDE_1
      return false
    end
    if @b.is_a?(Integer) == false && @b.is_a?(Float) == false
      @msg = MSG_NOT_NUM_SIDE_2
      return false
    end
    if @c.is_a?(Integer) == false && @c.is_a?(Float) == false
      @msg = MSG_NOT_NUM_SIDE_3
      return false
    end
    
    #0, マイナス値チェック
    if a < 1 || b < 1 || c < 1
      @msg = MSG_NOT_TRIANGLE
      return false
    end
  
    #成立条件チェック
    if (a + b) <= c
      @msg = MSG_NOT_TRIANGLE
      return false
    end
  
    if (b + c) <= a
      @msg = MSG_NOT_TRIANGLE
      return false
    end
  
    if (c + a) <= b
      @msg = MSG_NOT_TRIANGLE
      return false
    end
  
   @msg = MSG_TRIANGLE

   return true
  
  end
  
  # 三角形の成立条件チェック
  # @return [Integer] 三角形のタイプを返却
  def getTriangleType
  
    #三角形かチェックする
    if chkFormingCondition() == false
      return TYPE_NOT_TRIANGEL
    end
    
    #全ての辺の長さが同じ
    if @a == @b && @a == @c
      @msg = MSG_TRIANGLE_EQUILATERAL
      return TYPE_EQUILATERAL
    end
    
    #２辺の長さが同じ
    if @a == @b || @a == @c || @b == @c
      @msg = MSG_TRIANGLE_ISOSCELES
      return TYPE_ISOSCELES
    end

    @msg = MSG_TRIANGLE_SCALENE
    return TYPE_SCALENE
  
  end

end

#引数の数をチェック
if ARGV.length >= 3

  if ARGV[0] =~ /\A-?\d+(.\d+)?\Z/
    side1 = ARGV[0].to_f
  else
    puts "引数1の数が数値ではありません。"
    exit
  end

  if ARGV[1] =~ /\A-?\d+(.\d+)?\Z/
    side2 = ARGV[1].to_f
  else
    puts "引数2の数が数値ではありません。"
    exit
  end

  if ARGV[2] =~ /\A-?\d+(.\d+)?\Z/
    side3 = ARGV[2].to_f
  else
    puts "引数3の数が数値ではありません。"
    exit
  end

  #三角形のオブジェクトを作成
  triangle = Triangle.new()

  #辺の設定
  triangle.setTriangleSide(side1, side2, side3)

  #三角形のタイプを取得
  if triangle.getTriangleType() == Triangle::TYPE_NOT_TRIANGEL
    puts triangle.msg
  else
    puts triangle.msg
  end
  
end



