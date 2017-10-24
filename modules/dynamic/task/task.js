$('#D__ID').on('load',function(){
	$("#F__ID")[0].reset();
})

$('#F__ID').submit(function(event){
	event.preventDefault();
	save_record();
});

var save_record=function(record){

	if(_before_submit_form()==false) return;


	var module_name=$vm.vm["__ID"].name;
	var db_pid=$vm.module_list[module_name].table_id

	var data = {};
	if(record!=undefined) data=record;
	var a = $("#F__ID").serializeArray();
	$.each(a, function () {
		if (data[this.name]) {
			if (!data[this.name].push) {
				data[this.name] = [data[this.name]];
			}
			data[this.name].push(this.value || '');
		}
		else {
			data[this.name] = this.value || '';
		}
	});

	data.Participant=$vm.g_participant;
	data.Participant_uid=$vm.g_participant_uid;
	var dbv={
		S3:'#00FF00',
		PPID:$vm.g_participant_pid,
		PUID:$vm.g_participant_uid,
	}
	//-------------------------------------
	var req={cmd:"add_json_record_s2",db_pid:db_pid,data:data,dbv:dbv};
	$VmAPI.request({data:req,callback:function(res){
		if(res.ret<=0)	alert("Sorry there is a problem. You can try again later or wait until you are at Woolcock.")
		else{
			if($vm.module_list[module_name].alert=="1"){
				$vm.alert('Your data has been successfully submitted')
			}
			window.history.back(-1);
		}
	}});
	//-------------------------------------
};
