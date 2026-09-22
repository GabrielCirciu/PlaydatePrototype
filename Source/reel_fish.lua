function overlapping_fish_bobber_check()
    -- Check distance between the bobber and the bubble
    local distance = math.sqrt((bubblePosition[1] - bobber_x)^2 + (bubblePosition[2] - bobber_y)^2)
    if distance < 5 and not fishHooked then
        fishHooked = true
    end
end