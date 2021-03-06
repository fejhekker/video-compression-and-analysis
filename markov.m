clear all; close all;
load_test;

%get the data in a useful shape
for data=1:size(test_digits,3)*0.5
    train_data(data,:)=sum(test_digits(:,:,data),2); %get states
    for state=1:size(test_digits,2)
        sorted_data(test_labels(data)+1,data,state)=train_data(data,state); %sort data by label and state
    end
end

%train the HMMs 
for label=1:10
    for state=1:size(test_digits,2)
        avg(label,state)=sum(sorted_data(label,:,state))/size(test_digits,2);
        s_deviation(label,state)=std(sorted_data(label,:,state));
    end
end

%classify the new data
error=0;
confusion=zeros(10,10);
for data=1:size(test_digits,3)*0.5%size(test_digits,3):size(test_digits,3)
    test_data(data,:)=sum(test_digits(:,:,data+5000),2);
    for label=1:10
        for state=1:size(test_digits,2)
            if s_deviation(label,state)==0 %if all states where 0 (for example the upper row is never used the std will be zero, this gives errors when computing the probability so they are taken to be 1
                prob(data,label,state)=1;
            else
                prob(data,label,state)=(1/(sqrt(2*pi)*s_deviation(label,state)))*exp(-(test_data(data,state)-mean(label,state)).^2/(2*s_deviation(label,state)^2));
            end
        end
        chance(data,label)=prod(prob(data,label,:));
    end
    [prob_label(data),HMM_label(data)]=max(chance(data,:)); 
    if HMM_label(data)-1 ~=test_labels(data+5000)
        error=error+1;
    end
    confusion(HMM_label(data),test_labels(data+5000)+1)=confusion(HMM_label(data),test_labels(data+5000)+1)+1;
end

error_rate=error/5000;



        