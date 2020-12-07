#include<linux/init.h>
#include<linux/module.h>
#include<linux/moduleparam.h>

static char *whom = "world";
static int howmany = 1;

module_param(howmany,int,S_IRUGO);
module_param(whom,charp,S_IRUGO);

static int hello_init(void){
	while(howmany!=0){
		printk(KERN_ALERT "Hello %s\n",whom);
		howmany=howmany-1;
	}
	return 0;
}

static void hello_exit(void){
	printk(KERN_ALERT "Goodbye %s\n",whom);
}

module_init(hello_init);
module_exit(hello_exit);
