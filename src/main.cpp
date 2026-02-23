#include <QApplication>
#include <QMainWindow>


int main(int argc, char** argv) {
	QApplication a(argc, argv);
	a.setWindowIcon(QIcon(":/icon.png"));
	QMainWindow w{};

	w.show();
	return a.exec();
}