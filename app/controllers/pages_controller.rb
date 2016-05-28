class PagesController < ApplicationController
  def home
  	read_moves
  end
  def read_moves
  	@moves = Move.all
  end
  def add_move
  	mo  = Move.create(rc: params[:rc],value: 0)
    p_moves = []
    m_moves = []
    read_moves
    next_moves = []
    @moves.each do |m|
      if m.value == 0
      p_moves << m.rc   
      else
      m_moves << m.rc 
      end
    end

    almoves = [11,12,13,21,22,23,31,32,33] - p_moves - m_moves
    next_move = almoves.sample

    win_conditions  = [[11,12,13],[21,22,23],[31,32,33],[11,21,31],[12,22,32],[13,23,33],[11,22,33],[13,22,31]]
    win_conditions.each do |con|
    pl_com = con & p_moves
    m_com = con & m_moves
    if pl_com.size > 1
    if m_com.size != 1
    x = con - pl_com  
    next_moves << [x[0],2]  
    end  
    end
    if m_com.size > 1
    if pl_com.size == 0
    x = con - m_com  
    next_moves << [x[0],3]  
    end   
    end  
    end
    p = 0
    next_moves.each do |moves|  
    if moves[1] > p
    p = moves[1]
    next_move = moves[0]  
    end  
    end
    nm = Move.create(rc: next_move,value: 1)
    redirect_to root_path
  end

  def clear
  read_moves
  @moves.each do |m|
    m.delete
  end
  redirect_to root_path
end

end
