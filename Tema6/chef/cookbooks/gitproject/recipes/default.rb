directory "/home/melki/gitproject" do
	owner node['user']['name']
	group node['user']['group']
	mode 00755
	action :create
end

file "/home/melki/gitproject/README.md" do
	owner node['user']['name']
	group node['user']['group']
	mode 00644
	action :create_if_missing
	content "Proyecto base de GitHub"
end

remote_file "/home/melki/gitproject/LICENCE" do
	owner node['user']['name']
	group node['user']['group']
	mode 00644
	action :create_if_missing
	source "http://www.gnu.org/licenses/gpl-3.0.txt"
end
