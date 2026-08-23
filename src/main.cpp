#include <QApplication>
#include <QtSystemDetection>
#include <QMainWindow>


int main(int argc, char** argv) {
	QApplication a{ argc, argv };
	#ifdef Q_OS_LINUX
		a.setWindowIcon(QIcon{ ":/icon.png" });
	#endif
	a.setApplicationDisplayName("Template App");

	QMainWindow w{};
	w.show();

	return a.exec();
}