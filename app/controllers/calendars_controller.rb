class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
  end

  # 予定の保存
  def create
    # binding.pry
    Plan.create(plan_params)
    redirect_to action: :index

  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
    # params.require(:モデル名).permit(:キー名, :キー名) # 取得したいキーを指定する
    # https://master.tech-camp.in/v2/curriculums/4217
    # [1] pry(#<CalendarsController>)> params   としてもわかる
    # => <ActionController::Parameters {"authenticity_token"=>"AAFA8PqKBDrPloXs/YYFFSerDMP+NhA5hk46BnX3WyNIQtUzqegESkWVq1rYgbNgC/+VAR35Ty8PVYh2tjGT
  end

  def getWeek
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']

    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
      end
      days = { month: (@todays_date + x).month, date: (@todays_date+x).day, wday: wdays[(@todays_date + x).wday], plans: today_plans}
      @week_days.push(days)
    end

  end
end

# class CalendarsController < ApplicationController

#   # １週間のカレンダーと予定が表示されるページ
#   def index
#     getWeek
#     @plan = Plan.new
#   end

#   # 予定の保存
#   def create
#     # binding.pry
#     Plan.create(plan_params)
#     redirect_to action: :index

#   end

#   private

#   def plan_params
#     params.require(:plan).permit(:date, :plan)
#     # params.require(:モデル名).permit(:キー名, :キー名) # 取得したいキーを指定する
#     # https://master.tech-camp.in/v2/curriculums/4217
#     # [1] pry(#<CalendarsController>)> params   としてもわかる
#     # => <ActionController::Parameters {"authenticity_token"=>"AAFA8PqKBDrPloXs/YYFFSerDMP+NhA5hk46BnX3WyNIQtUzqegESkWVq1rYgbNgC/+VAR35Ty8PVYh2tjGT
#   end

#   def getWeek
#     # wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
#     # https://docs.ruby-lang.org/ja/2.6.0/class/Date.html

#     wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
#     # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
#     @todays_date = Date.today
#     # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

#     @week_days = []

#     plans = Plan.where(date: @todays_date..@todays_date + 6)

#     7.times do |x|
#       today_plans = []
#       plans.each do |plan|
#         today_plans.push(plan.plan) if plan.date == @todays_date + x
#       end
      
#       # days = { :month => (@todays_date + x).month, :date => (@todays_date+x).day, :plans => today_plans}
#       # days = { :month => (@todays_date + x).month, :date => (@todays_date + x).day, :plans => today_plans, :wday => wdaysから値を取り出す記述}

      
#       wday_num = Date.today.wday + x
#       # Memo1
#       # wdays[]
#       # Memo2
#       # @todays_date + x
#       # wday_num = Date.today.wday + x　今日の曜日のwdayを呼び出す。timesメソッドのxと連結

#         # if wday_num >= 7  //7で繰り返す
#         # wday_num = wday_num -7
#         # end
#       # [0,1,2,3,4,5,6]
#       # wdayメソッドを用いて取得した数値
#       if #「wday_numが7以上の場合」という条件式
#         wday_num >= 7
#         wday_num = wday_num -7


#       end

#       days = { month: (@todays_date + x).month, date: @todays_date.day + x,
#         # :month => (@todays_date + x).month, :date => @todays_date + x,
#         #  (@todays_date + x).day, 
        
#         # :plans => today_plans, 
#         # :wday => [(@todays_date + x).wday], plans :plans
#         wday: wdays[(@todays_date + x).wday], plans: plans
#         # wdaysから値を取り出す記述
#       }

      
#       @week_days.push(days)
#     end

#   end
# end
