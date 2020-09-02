for i=1:100
    y(i) = i;
end
filename = 'legion_test';
save(filename, 'y');
exit